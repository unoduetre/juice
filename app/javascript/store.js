import { makeAutoObservable } from 'mobx';

class Store {
  stockSymbols = [];
  stockPrices = {};
  minVolume = 0;

  constructor() {
    makeAutoObservable(this);
    setInterval(() => this.fetchStockSymbols(), 3 * 1000);
  }

  setMinVolume(value) {
    this.minVolume = value;
  }

  setStockSymbols(symbols) {
    this.stockSymbols = symbols; 
  }

  fetchStockSymbols() {
    fetch('/stock_symbols', {method: 'GET'})
    .then(response => response.json())
    .then(parsedResponse => {
      this.setStockSymbols(parsedResponse.body);
      for(const stockSymbol of this.stockSymbols) {
        this.fetchStockPrices(stockSymbol.id);
      }
    });
  }

  fetchStockPrices(stockSymbolId) {
    fetch(`/stock_symbols/${stockSymbolId}/stock_prices.json?min_volume=${this.minVolume}`, {method: 'GET'})
    .then(response => response.json())
    .then(parsedResponse => {
      this.stockPrices[stockSymbolId] = parsedResponse.body;
    });
  }

  addStockSymbol(stockSymbol) {
    fetch('/stock_symbols', {
      method: 'POST',
      body: new URLSearchParams(`stock_symbol[symbol]=${stockSymbol}`),
      headers: this.headers()
    })
    .then(response => response.json())
    .then(parsedResponse => {
      this.fetchStockSymbols();
    });
  }

  deleteStockSymbol(stockSymbolId) {
    fetch(`/stock_symbols/${stockSymbolId}`, {
      method: 'DELETE',
      headers: this.headers()
    })
    .then(response => response.json())
    .then(parsedResponse => {
      this.fetchStockSymbols();
    });
  }

  headers() {
    const token = document.getElementsByName('csrf-token')[0].content;
    const headers = new Headers();
    headers.append('X-CSRF-Token', token);
    return headers;
  }
}

export default new Store();
