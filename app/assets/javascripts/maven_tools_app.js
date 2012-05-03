//= require jquery
//= require jquery_ujs
//= require lib/jqueryui
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require bootstrap-dropdown
//= require bootstrap-alert
//= require apps/maven_tools/actions.js

jQuery(document).ready(function($) {
  $('.dropdown-toggle').dropdown();
  $(".alert").alert();
});
