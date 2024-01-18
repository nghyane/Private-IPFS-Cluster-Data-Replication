cp -r ./common/* ./manager
cp -r ./common/* ./worker
rm -rf ./worker/keygen || true
rm -rf ./worker/dicom-files || true
rm -rf ./worker/pdf-files || true
