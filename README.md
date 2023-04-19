# XYZ SHARED

## Overview

*XYZ Shared* is an important component of the *XYZ Framework for Flutter*. It is designed to work seamlessly with the following tools:

- The app template `xyz_template` (that depends on `xyz_shared`)
- The package [xyz_engine_generators_annotations](https://github.com/robmllze/xyz_engine_generators_annotations)
- The package [_xyz_engine_generators](https://github.com/robmllze/_xyz_engine_generators)
- The package [xyz_config](https://github.com/robmllze/xyz_config)
- The package [xyz_pod](https://github.com/robmllze/xyz_pod)
- The package [xyz_utils](https://github.com/robmllze/xyz_utils)

## Installation instructions

1. Download this package from GitHub by clicking on this [link](https://github.com/robmllze/xyz_shared/archive/refs/heads/master.zip).
2. Extract the downloaded zip file and copy the `xyz_shared` folder.
3. Navigate to your project's `lib` folder and paste the `xyz_shared` folder there.
4. Add the following line to your `all.dart` file: `export '/xyz_shared/shared.dart';`
5. Set up the xyz_shared package for your project by copying the `COPY_ME_TO_LIB_FOLDER.xyz_config.dart` file and save it as `lib/xyz_config.dart`. Then, modify the file according to your project's requirements.
5. There is no `pubspec.yaml` file included with this package. It is designed to be integrated with your project and updated as you make changes to your project.
6. To ensure you have the latest version of this package, regularly pull updates from the GitHub repository.