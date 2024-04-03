# How to install custom GApps

1. Build WSA without gapps to let the script download needed files

    `./build.sh --gapps-brand none`
1.
    - For OpenGApps

        Place custom OpenGApps to `download` folder and rename to `OpenGApps-{arch}-{variant}.zip` (e.g. `OpenGApps-x64-pico.zip`)
    - For MindTheGapps

        Place custom MindTheGapps to `download` folder and rename to `MindTheGapps-{arch}.zip` (e.g. `MindTheGapps-x64.zip`)
1. Build WSA offline

    `./build.sh --offline --gapps-brand {brand} --gapps-variant {variant}`
