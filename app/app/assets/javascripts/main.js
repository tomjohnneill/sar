document.forms.lookup.addEventListener('submit', function (evt) {
    evt.preventDefault();
    var xhr = new XMLHttpRequest();
    var url = window.location.protocol + '//' + window.location.host + "/report?postcode=" + document.forms.lookup.elements.postcode.value;
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
                '',
                'Median',
                'Lowest',
                'Highest'
            ],
            datasets: [
                {
                  label: "Allowance",
                  backgroundColor: "#3e9500",
                  data: [
                      data.government_allowance
                  ]
                },
                {
                  label: "LHA",
                  backgroundColor: "#3e95cd",
                  data: [
                      0,
                      data.rent_distribution.values[50][1],
                      data.rent_distribution.values[0][1],
                      data.rent_distribution.values.slice(-1)[0][1]
                  ]
                },
                {
                  label: "Spare room",
                  backgroundColor: "#8e5ea2",
                  data: [
                      0,
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
                  borderColor: "#3e95cd",
                  data: data.rent_distribution.values.map(function (p) {
                      return {'x': p[0], 'y': p[1]};
                  }),
                  fill: false,
                    pointRadius: 0
                },
                {
                  borderColor: "transparent",
                  backgroundColor: "#3e9500",
                  data: [{
                      'x': data.rent_distribution.lha_rate[0],
                      'y': data.rent_distribution.lha_rate[1]
                  }, {
                      'x': data.rent_distribution.values[30][0],
                      'y': data.rent_distribution.values[30][1]
                  }],
                  fill: false,
                    pointRadius: 10
                }
            ]
        },
        options: {
          responsive: false,
          legend: { display: false },
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

    document.querySelector('.js-stats').innerHTML = 
        'Your area is ' + data.brma + '. The rate in this area is £' + data.government_allowance + '<br /><br />' +
        'Our research shows that you can afford ' +
        (data.rooms_below_threshhold / data.number_rooms).toFixed(1) + '% ' +
        'of available homes.';
}
