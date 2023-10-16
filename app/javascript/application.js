import React from 'react';
import { createRoot } from 'react-dom/client';
import { observer } from 'mobx-react-lite';
import Spreadsheet from 'react-spreadsheet';
import { Plot, LineSeries } from 'react-plot';
import store from './store.js';

const App = observer(() => {
  function stockPricesToSpreadsheet(prices) {
    return prices.map(price => [
      {value: price.timestamp},
      {value: price.open},
      {value: price.close},
      {value: price.high},
      {value: price.low},
      {value: price.volume}
    ]);
  }

  function stockPricesToPlot(prices) {
    return prices.map((price, index) =>
      ({x: index, y: (Number.parseFloat(price.high) + Number.parseFloat(price.low)) / 2})
    );
  }

  return pug`
    div
      label(for='new-stock-symbol') Stock Symbol
      input(type='text' id='new-stock-symbol' name='new-stock-symbol')
      input(type='button' value='Add' onClick=() => store.addStockSymbol(document.getElementById('new-stock-symbol').value))
    div
      label(for='min-volume') Minimal Volume
      input(type='text' id='min-volume' value=store.minVolume onChange=() => store.setMinVolume(document.getElementById('min-volume').value))
    each stockSymbol in store.stockSymbols
      h1(key=(stockSymbol.symbol + '-h1'))= stockSymbol.symbol
      a(key=(stockSymbol.symbol+ '-a') href='/stock_symbols/'+stockSymbol.id+'/stock_prices.csv?min_volume='+store.minVolume) CSV
      input(key=(stockSymbol.symbol + '-i') type='button' value='Delete' onClick=() => store.deleteStockSymbol(stockSymbol.id))
      if store.stockPrices[stockSymbol.id]
        - const prices = store.stockPrices[stockSymbol.id];
        Plot(key=(stockSymbol.symbol + '-plot') width=500 height=500)
          LineSeries(key=(stockSymbol.symbol + '-lines') data=stockPricesToPlot(prices) xAxis='x' yAxis='y')
        Spreadsheet(key=(stockSymbol.symbol + '-spr') data=stockPricesToSpreadsheet(prices))
  `;
});

createRoot(document.getElementById('app')).render(pug`App`);
