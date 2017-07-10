fetch(`https://api.github.com/users/${userLogin}/repos?access_token=${userToken}`)
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
