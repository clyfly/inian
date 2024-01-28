# sync rom
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
git clone https://github.com/clyfly/local_manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_rosemary-user
export TZ=Asia/Jakarta #put before last build command
m bacon
