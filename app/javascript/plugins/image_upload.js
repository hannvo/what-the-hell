const submitImgOnUpload = () => {
  const uploadedImg = document.getElementById("search_photo");
  if (uploadedImg && uploadedImg.value != "") {
    uploadedImg.submit();
  }
};

export { submitImgOnUpload };
