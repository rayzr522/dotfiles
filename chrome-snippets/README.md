# chrome-snippets

> A collection of small browser snippets used for automating annoying tasks.

Why do it by hand when you can spend 8 hours writing a script to do it for you?

## How to use them

Just copy the contents of one of these scripts, make a new bookmark in Chrome, and paste the contents as a URL. This may work in other browsers, but I haven't tried, so I can't assume it will.

## How to make them

Keep in mind that these are essentially being smashed into your URL bar from the bookmark, meaning there are no actual newlines. This means you MUST add semicolons to the end of each line to ensure that there is separation between your lines of code.

As for what you can do, basically anything that works in the Chrome console works here. Keep in mind that, when activating a bookmark, the document is actually not focused for a few milliseconds. This means anything that requires document focus (such as requesting contents from the user's clipboard) will have to be delayed to give time for the page to refocus.

Another good practice is to wrap these snippets in anonymous functions or lambdas. This just makes sure that you are less likely to pollute the global scope with conflicting variables, and also means you can safely work with immutable `const` variables without having to worry that you'll have to reload the page each time to try a new vesrion of your script.

## DISCLAIMER

These were written using hacky query selectors and assume that these websites dont change their design or code ever. Which likely will end up changing eventually, thereby breaking these scripts. Use at your own risk :)
