# XYZ SHARED

## Overview

*XYZ Shared* is an important component of the *XYZ Framework for Flutter*. It is designed to work seamlessly with the following tools:

- The app template `xyz_template` (that depends on `xyz_shared`)
- The package [_xyz_generate_exports](https://github.com/robmllze/_xyz_generate_exports)
- The package [_xyz_generate_makeups](https://github.com/robmllze/_xyz_generate_makeups)
- The package [_xyz_generate_models](https://github.com/robmllze/_xyz_generate_models)
- The package [_xyz_generate_screen_access](https://github.com/robmllze/_xyz_generate_screen_access)
- The package [_xyz_generate_makeups_annotations](https://github.com/robmllze/_xyz_generate_makeups_annotations)
- The package [_xyz_generate_models_annotations](https://github.com/robmllze/_xyz_generate_models_annotations)
- The package [_xyz_generate_screen_access_annotations](https://github.com/robmllze/_xyz_generate_screen_access_annotations)

- The package [xyz_config](https://github.com/robmllze/xyz_config)
- The package [xyz_pod](https://github.com/robmllze/xyz_pod)
- The package [xyz_utils](https://github.com/robmllze/xyz_utils)

## Installation instructions

1. Download this package from GitHub by clicking on this [link](https://github.com/robmllze/xyz_shared/archive/refs/heads/master.zip).
2. Extract the downloaded zip file and copy the `xyz_shared` folder.
3. Navigate to your project's `lib` folder and paste the `xyz_shared` folder there.
4. Add the following line to your `all.dart` file: `export '/xyz_shared/shared.dart';`
5. Set up the xyz_shared package for your project by copying the `COPY_ME_TO_LIB_FOLDER.xyz_shared_config.dart` file and save it as `lib/xyz_shared_config.dart`. Then, modify the file according to your project's requirements.
5. There is no `pubspec.yaml` file included with this package. It is designed to be integrated with your project and updated as you make changes to your project.
6. To ensure you have the latest version of this package, regularly pull updates from the GitHub repository.

## Pro installation instructions

1. Place the script `fetch_xyz_shared.dart` included in this project in your project root directory.
2. Run it with `dart fetch_xyz_shared.dart`
3. The contents should be extracted to `lib/xyz_shared`