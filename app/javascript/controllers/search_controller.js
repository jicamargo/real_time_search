import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "resultList"]

  connect() {
    // console.log("Hello, Stimulus!", this.element)
  }

  input(){
    const key = this.inputTarget.value.slice(-1);

    console.log('key: ' + key);
    if (
      key === ' ' || 
      key === '.' || 
      key === ',' 
    ) {
        console.log('llamando a search');
        this.search();
    }
  }

  search(event) {
    const searchResults = this.resultListTarget;
    const query = this.inputTarget.value.trim();

    // Calls the controller action /search/index with the query parameter
    fetch(`/search/get_queries?query=${query}`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Network response error: ${response.status}`);
        }
        return response.json();
      })
      .then(results => {
        // Fisrt clear all and Add results to list
        searchResults.innerHTML = '';

        if (Array.isArray(results)) {
          results.forEach(result => {
            const listItem = document.createElement('li');
            listItem.textContent = result;
            searchResults.appendChild(listItem);
          });
        }
    })
    .catch(error => console.error('Error getting queries:', error));
  }

  reset() {
    this.inputTarget.value = '';
    this.resultListTarget.innerHTML = '';
    fetch(`/search/reset`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Network response error: ${response.status}`);
        }
    })
  }
}
