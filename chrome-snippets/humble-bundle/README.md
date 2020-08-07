# humble-bundle

> Scripts for quickly reviewing Steam keys from a Humble Bundle order and determining which to redeem or not.

## grab-bundle-games

This script allows you to reveal all Steam keys on a Humble Bundle downloads page, then copy them to the clipboard, along with the game names, for usage with the `review-bundle-games` script.

Can only be used on pages in the format of: `https://www.humblebundle.com/downloads?key=<some key>`

## review-bundle-games

This script allows you to review the Steam games & keys you copied using `grab-bundle-games`, checking whether each one is in your library or not.

To cycle through games, just hit `Next Game`. Games which were automatically determined to be in your library will not be cycled through. Keep in mind that just because a game is or is not listed when you search for it, you may not or actually may have said game, simply because Humble Bundle doesn't use the exact same game names as Steam.

If you find that a game is not in your library, simply hit the `Redeem` button and a redeem page with the corresponding key will be opened.

If you didn't have the output from `grab-bundle-games` in your clipboard when running this script, and wish to reload from clipboard, just press `Clipboard`
