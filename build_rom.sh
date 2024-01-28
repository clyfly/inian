# sync rom
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone Device tree
git clone https://github.com/Sicantik-Hanya-Gabut/DT.git -b rad device/xiaomi/rosemary

# build rom
source build/envsetup.sh
lunch lineage_rosemary-user
export TZ=Asia/Jakarta #put before last build command
m bacon
