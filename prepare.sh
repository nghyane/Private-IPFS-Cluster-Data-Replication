cp -r ./common/* ./manager
cp -r ./common/* ./worker
rm -rf ./manager/ipfs-setup-worker.sh || true
rm -rf ./worker/ipfs-setup-manager.sh || true
rm -rf ./worker/dicom-files || true
rm -rf ./worker/pdf-files || true
