javascript:/* lets you review games from Humble Bundle */

setTimeout(async () => {
    const STEAM_USER_ID = 'rayzr522';
    const STEAM_GAMES_URL = `https://steamcommunity.com/id/${STEAM_USER_ID}/games/?tab=all`;

    if (window.location.href !== STEAM_GAMES_URL) {
        if (!confirm('Do you want to go to your Steam game page?')) {
            return;
        };

        window.location.href = STEAM_GAMES_URL;
    };

    const shuffle = arr => arr.push(arr.shift());

    const buttonContainerId = 'review-bundle-games-button-container';
    const existingContainer = document.getElementById(buttonContainerId);

    if (existingContainer) existingContainer.remove();

    const buttonContainer = document.createElement('div');
    buttonContainer.id = buttonContainerId;
    buttonContainer.style.position = 'absolute';
    buttonContainer.style.top = '-4px';
    buttonContainer.style.left = '-4px';
    buttonContainer.style.width = '96px';
    buttonContainer.style.height = '96px';
    buttonContainer.style.padding = '8px';
    buttonContainer.style.display = 'flex';
    buttonContainer.style.flexDirection = 'column';
    buttonContainer.style.alignItems = 'stretch';
    buttonContainer.style.justifyContent = 'space-around';
    document.body.appendChild(buttonContainer);

    const makeButton = text => {
        const button = document.createElement('button');
        button.innerText = text;
        button.style.border = '0';
        button.style.padding = '5px';
        button.style.zIndex = '10000';
        button.style.textAlign = 'center';
        button.classList.add('pullup_item');
        buttonContainer.appendChild(button);

        return button;
    };

    const doesntHaveGame = game => {
        if (!rgGames || !rgGames.length) {
            return true;
        };

        return !rgGames.some(it => it.name.toLowerCase() === game.name.toLowerCase());
    };

    const eolGame = { name: '(EOL)', key: null };

    let games;

    const reload = async () => {
        const clipboardLines = (await window.navigator.clipboard.readText()).split('\n');

        games = [eolGame, ...clipboardLines.map(it => {
            const [name, key] = it.split('\t\t');
            return { name, key };
        })].filter(doesntHaveGame);
    };

    await reload();

    const nextGameButton = makeButton('Next Game');
    const redeemGameButton = makeButton('Redeem');
    const reloadButton = makeButton('Reload');

    nextGameButton.onclick = () => {
        const gameFilter = document.getElementById('gameFilter');
        shuffle(games);

        gameFilter.value = games[0].name;
        redeemGameButton.disabled = !games[0].key;

        filterApps();
    };

    redeemGameButton.disabled = true;
    redeemGameButton.onclick = () => {
        const currentGame = games[0];
        if (!currentGame.key) {
            return;
        };
        
        window.open(`https://store.steampowered.com/account/registerkey?key=${currentGame.key}`, '_blank');
    };

    reloadButton.onclick = () => reload();
}, 10)
