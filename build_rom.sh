# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b eleven  --depth=1

# Clone Device tree
git clone -b 11 https://github.com/heyradrepo/local_manifests .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j4

# Clone Device tree
git clone -b 11 https://github.com/heyradrepo/local_manifests .repo/local_manifests

# build rom
. build/envsetup.sh
lunch cherish_rosemary-userdebug
export TZ=Asia/Jakarta #put before last build command
brunch rosemary userdebug
