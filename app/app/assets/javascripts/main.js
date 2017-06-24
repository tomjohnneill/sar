document.forms.lookup.addEventListener('submit', function (evt) {
    evt.preventDefault();
    var xhr = new XMLHttpRequest();
    var url = 'http://' + window.location.host + `/report?postcode=${document.forms.lookup.elements.postcode.value}`;
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
    document.querySelector('.js-results').style.display = 'block';

    var ctx = document.getElementById("comparison").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: [
                'Allowance',
                'Lowest',
                'Highest'
            ],
            datasets: [
                {
                  label: "LHA",
                  backgroundColor: "#3e95cd",
                  data: [
                      data.rent_distribution[50][1],
                      data.rent_distribution[0][1],
                      data.rent_distribution.slice(-1)[0][1]
                  ]
                },
                {
                  label: "Spare room",
                  backgroundColor: "#8e5ea2",
                  data: [
                      data.results.spareroom.median_rent,
                      data.results.spareroom.lowest_rent,
                      data.results.spareroom.highest_rent
                  ]
                }
            ]
        },
        options: {
          responsive: false,
          title: {
                display: true,
                text: 'Is the Housing Allowance really enough?'
            },
            scales: {
                xAxes: [{ticks: {min: 0}}]
            }
        }
    });

    var ctx2 = document.getElementById("distribution").getContext('2d');
    var myChart2 = Chart.Scatter(ctx2, {
        data: {
            datasets: [
                {
                  label: "Price",
                  borderColor: "#3e95cd",
                  data: data.rent_distribution.map(([x, y]) => ({x, y})),
                  fill: false
                }
            ]
        },
        options: {
          responsive: false,
          legend: { display: false },
          elements: { point: { radius: 0 } },
          title: {
                display: true,
                text: 'Government distribution'
            },
            scales: {
                xAxes: [{ticks: {min: 0}}],
                yAxes: [{ticks: {min: 0}}]
            }
        }
    });

    document.querySelector('.js-stats').textContent = "" +
        "Our research shows that you can afford" +
        (data.rooms_below_threshhold / data.number_rooms).toFixed(1) + "%" +
        "of available homes.";
}
