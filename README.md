# Android Compilers

This is a repo manifest that downloads the Android prebuilt compilers; useful for alternative OS development on Nexus devices.
The idea is this manifest and script will download prebuilts and link them so they might be available for use with ccache and distcc. Think rbenv but for compilers and cross-compiling. Might be a game changer in containerization for deployment on metal.

A work in progress as a result of multitasking in several projects.
Right now it downloads compilers to a common path.

```
curl -#L https://raw.githubusercontent.com/KellyLSB/android-compilers/master/install.sh | bash
```

