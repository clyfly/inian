# sync rom
repo init -u https://github.com/alphadroid-project/manifest -b alpha-13 --git-lfs
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone Device tree
https://github.com/Sicantik-Hanya-Gabut/XYZ-DT -b linear device/xiaomi/rosemary

# Cleaning Kernel tree
cd kernel/xiaomi/rosemary && make clean
cd -

# build rom
source build/envsetup.sh
lunch lineage_rosemary-user
export TZ=Asia/Jakarta #put before last build command
make bacon
