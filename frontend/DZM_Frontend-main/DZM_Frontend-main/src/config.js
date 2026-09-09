import axios from 'axios';

export const env = "dev";

export const settings = {
  dev: {
    backendUrlBase: "http://8.138.21.99:8000",
    frontendUrlBase: "http://8.138.21.99:3000",
    domain: "8.138.21.99",
  },
  prod: {
    backendUrlBase: "https://code.dachengoffer.com/api",
    frontendUrlBase: "https://code.dachengoffer.com",
    domain: ".dachengoffer.com",
  }
};

axios.defaults.withCredentials = true;

export let headerHeight = 80;
