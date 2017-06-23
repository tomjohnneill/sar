var inputField = document.querySelector('.postcode');
var submitButton = document.querySelector('.submitButton');
var postcode = inputField.value;

submitButton.addEventListener('click', sendPostcode);

function sendPostcode () {
  var xhr = new XMLHttpRequest();
  var url = `/data?${postcode}`;
  xhr.onreadystatchange = function() {
      if (xhr.readyState == 4 && xhr.status == 200) {
        var roomData = JSON.parse(xhr.responseText);
        handleRoomData(roomData);
      }
  };
  xhr.open("GET", url, true);
  xhr.send();
};

function handleRoomData (data) {
  // This is where we take the data and render it
  console.log(data);
}
