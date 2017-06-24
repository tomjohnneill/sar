document.forms.lookup.addEventListener('submit', function (evt) {
    evt.preventDefault();
    var xhr = new XMLHttpRequest();
    var url = `/report?postcode=${document.forms.lookup.elements.postcode.value}`;
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var roomData = JSON.parse(xhr.responseText);
            console.log(roomData);
          render(roomData);
        }
    };
    xhr.open("GET", url, true);
    xhr.send();
});

function render(data) {
    var ctx = document.getElementById("myChart").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: ['LHA allowance', 'Spare rooms average'],
            datasets: [
                {
                  label: "Price",
                  backgroundColor: "#3e95cd",
                  data: [
                      data.government_allowance,
                      data.results.spareroom.median_rent
                  ]
                }
            ]
        },
        options: {
          responsive: false,
          legend: { display: false },
          title: {
                display: true,
                text: 'Is the Housing Allowance really enough?'
            },
            scales: {
                xAxes: [{ticks: {min: 0}}]
            }
        }
    });

}
