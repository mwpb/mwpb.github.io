let idx;
let lookUp = {};
let getJson = async () => {
  let response = await fetch("/search_data.json");
  let text = await response.text();
  return JSON.parse(text);
};
(async () => {
  let documents = await getJson();
  idx = lunr(function () {
    this.ref("href");
    this.field("content");
    this.field("tags");

    documents.forEach(function (doc) {
      lookUp[doc["href"]] = doc["title"];
      this.add(doc);
    }, this);
  });

  displayResults();
})();

let search = (searchString, tagList) => {
  if (searchString) {
    let strings = searchString.split(" ");
    searchString = "";
    for (const s of strings) {
      searchString += `+content:${s}~3 `;
    }
  }
  for (const tag of tagList) {
    searchString += "+tags:"+tag+" ";
  }
  console.log(`Searching for: ${searchString}`);
  return idx.search(searchString);
};

let searchInput = document.getElementById("searchInput");
let resultsDiv = document.getElementById("results");

let displayResults = () => {
  let tags = [];
  let  checkedBoxes = document.querySelectorAll('input:checked');
  console.log(checkedBoxes);
  for (const box of checkedBoxes) {
    console.log(box.id)
    tags.push(box.id);
  }

  resultsDiv.innerHTML = "";
  let results = search(searchInput.value, tags);
  for (const result of results) {
    let resultDiv = document.createElement("div");
    let a = document.createElement("a");
    a.href = result.ref;
    console.log(lookUp)
    a.innerText = lookUp[result.ref]
    resultsDiv.appendChild(a);
  }
};

searchInput.addEventListener("keyup", displayResults);
searchInput.addEventListener("paste", displayResults);
let checkedBoxes = document.querySelectorAll('input');
for (const box of checkedBoxes) {
  box.addEventListener("click", displayResults);
}