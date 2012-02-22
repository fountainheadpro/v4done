//= require jquery
//= require jquery_ujs
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/actions
//= require_tree .
//= require bootstrap-dropdown
//= require bootstrap-alert
jQuery(document).ready(function($) {
  $('.dropdown-toggle').dropdown();
  $(".alert").alert();
});
