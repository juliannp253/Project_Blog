// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

import { Dropdown } from 'bootstrap'

document.addEventListener("turbo:load", () => {
  document.querySelectorAll('.dropdown-toggle').forEach(dropdownToggleEl => {
    new Dropdown(dropdownToggleEl)
  });
});
