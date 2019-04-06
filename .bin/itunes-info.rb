#!/usr/bin/env ruby

require "net/http"
require "uri"
require "json"

def get(url)
    uri = URI.parse(url)
    Net::HTTP.get_response(uri).body
end

def search(query)
    response = get "https://itunes.apple.com/search?limit=1&term=#{URI.encode query}"
    JSON.parse(response.strip)
end

def prompt(query)
    print query
    STDIN.gets.chomp
end

file = ARGV.join ' '
if file.empty?
    puts "Usage: #{$0} <file>"
    exit 1
end

if !File.exist? file
    puts "The file '#{file}' does not exist."
    exit 1
end

query = prompt "Please enter a query to search for: "
if query.empty?
    puts "You must enter something to search for."
    exit 1
end

response = search query
if response['resultCount'] == 0
    puts "No results found for '#{query}'"
    exit 1
end

result = response['results'][0]

track = result['trackName']
artist = result['artistName']
album = result['collectionName']
albumArtist = result['collectionArtistName'] || artist
genre = result['primaryGenreName']
artworkURL = result['artworkUrl100'].sub '100x100', '500x500'

puts "
---| #{track} |---
by: #{artist}
from: #{album}
album artist: #{albumArtist}
genre: #{genre}
artwork URL: #{artworkURL}
".strip

puts

if prompt("Is this what you were looking for? [y/N] ").upcase[0] != "Y"
    exit 1
end

img = get(artworkURL)
File.write('/tmp/track-artwork', img)

cmd = "eyeD3 '#{file}' --title '#{track}' --album '#{album}' --artist '#{artist}' --album-artist '#{albumArtist}' --genre '#{genre}' --add-image '/tmp/track-artwork:FRONT_COVER'"

puts "Running command: #{cmd}"

if !system cmd
    puts "An error has occurred while writing ID3 metadata!"
    exit 1
end

File.delete('/tmp/track-artwork')
