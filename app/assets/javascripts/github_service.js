var userToken = '2ba73b3b838b5bf80a2108442eca54efeaef4eb9';
var userLogin = 'charliecorrigan';

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
