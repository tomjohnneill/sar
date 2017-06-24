var brma = [];
var data = [];
var response = JSON.stringify([
  {
    "brma": "Some Name",
    "government_allowance": 590,
    "average_rent": {
      "spareroom": 830,
      "zoopla": 870
    },
    "number_rooms": 620,
    "rooms_below_threshhold": 0
  },
  {
    "brma": "Shoreditch",
    "government_allowance": 700,
    "average_rent": {
      "spareroom": 1000,
      "zoopla": 1100
    },
    "number_rooms": 900,
    "rooms_below_threshhold": 5
  }
]);

(function () {
  JSON.parse(response).forEach(home => {
    brma.push(home.brma);
    data.push({label: "Government allowance", data: [home.government_allowance]},
              {label: "Spareroom", data: [home.average_rent.spareroom]})
  });
}) ();

var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
      labels: brma,
      // datasets: [
      //   {
      //     label: "Africa",
      //     backgroundColor: "#3e95cd",
      //     data: [133,221,783,2478]
      //   }, {
      //     label: "Europe",
      //     backgroundColor: "#8e5ea2",
      //     data: [408,547,675,734]
      //   }
      // ]
      datasets: data
    },
    borderWidth: 1,
    options: {
      responsive: false,
      title: {
            display: true,
            text: 'Title here'
        }
    }
});

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
}

function handleRoomData (data) {
  // This is where we take the data and render it
  console.log(data);
}
