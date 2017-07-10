fetch('https://api.github.com/users/charliecorrigan/repos?access_token=5ba8a157ec89132f049361ac600651b2460b929e')
  .then(respondsToJSON)
  .then(selectRepoAttributes)

  function respondsToJSON(response) {
    return response.json();
  }

  function selectRepoAttributes(data) {
    var mappedData = data.map(mapData)
    console.log(mappedData);
    document.getElementById("repos").innerHTML = mappedData;
  }

  function mapData(data_hash) {
    return data_hash["name"];
  }