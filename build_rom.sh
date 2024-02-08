# sync rom
repo init -u https://github.com/HorizonDroid-13/manifest.git -b 13
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone Device tree
https://github.com/Sicantik-Hanya-Gabut/XYZ-DT -b linear device/xiaomi/rosemary

# build rom
. build/envsetup.sh
lunch aosp_rosemary-user
export TZ=Asia/Jakarta #put before last build command
make bacon
