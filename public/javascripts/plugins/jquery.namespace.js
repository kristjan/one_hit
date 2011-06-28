/**
 * By Kamil Tusznio: https://gist.github.com/1041451
 *
 * Introducing the $.namespace function! It takes a string and gives you a
 * global representing the namespace you want.
 *
 * For example, $.namespace("Causes.Earn.Dialog") => {Earn: {Dialog: {}}}
 *
 * This gets rid of crufty code like:
 *
 * if (!Causes) { Causes = {}; }
 * if (!Causes.Earn) { Causes.Earn = {}; }
 *
 * Allowing you to simply call:
 *
 * $.namespace("Causes.Earn");
 * Causes.Earn = ...
 *
 * In case you're terrified, the function won't overwrite any previously-defined
 * globals, so if Causes already contains a bunch of stuff but still doesn't have
 * an Earn namespace, the function will just add the Earn namespace and leave Causes
 * intact otherwise.
 *
 * Additionally, you can pass in an object to immediately populate
 * the namespace with:
 *
 * $.namespace("Causes.Earn", {doStuff: function() { ... }}); =>
 *   Causes = {Earn: {doStuff: function() { ... }}};
**/

jQuery.extend({
  namespace: function(s, obj, scope) {
    var arr = s.split(".");

    scope = scope || window;

    $.each(arr, function(i, token) {
      scope[token] = scope[token] || {};
      scope = scope[token];
    });

    return $.extend(scope, obj);
  }
});
