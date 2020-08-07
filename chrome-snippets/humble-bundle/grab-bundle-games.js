javascript:/* lets you copy a page full of Humble Bundle games to clipboard */

(async () => {
    if (!window.location.href.startsWith('https://www.humblebundle.com/downloads')) {
        alert('Please run this script from an order download page, something in the format of:\n\nhttps://www.humblebundle.com/downloads?key=<some key>');
        return;
    };

    const getRedeemable = () => Array.from(document.querySelectorAll('.key-redeemer .js-keyfield.enabled:not(.redeemed)'));
    const sleepMillis = ms => new Promise(resolve => setTimeout(resolve, ms));

    if (getRedeemable().length) {
        let i = 0;
        getRedeemable().forEach(it => it.click());

        while (getRedeemable().length > 0 && i < 10) {
            i++;
            await sleepMillis(1000);
        };
    };

    /* check again */
    if (getRedeemable().length) {
        alert('Failed to redeem all keys!');
        return;
    };

    const games = Array.from(document.querySelectorAll('.key-redeemer'))
        .map(it => {
            const name = it.querySelector('.heading-text > h4').innerText;
            const key = it.querySelector('.js-keyfield.redeemed').title;
            return [name, key];
        });

    if (confirm(`Do you want to copy ${games.length} game names + keys to clipboard?`)) {
        setTimeout(async () => {
            await window.navigator.clipboard.writeText(
                games.map(it => it.join('\t\t')).join('\n')
            );

            alert(`Copied ${games.length} games to clipboard.`);
        }, 10);
    };
})()
