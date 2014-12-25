var app = angular.module('blog', [
  'ngRoute',
  'ngResource',
  'templates',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'ng-rails-csrf'
]);

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider
  .when('/', {
    templateUrl: 'index.html',
    controller: 'PostsController',
    reloadOnSearch: false
  })
  .when('/posts/new', {
    templateUrl: "newPost.html",
    controller: 'PostController'
  })
  .when('/posts/:id', {
    templateUrl: "showPost.html",
    controller: 'PostController'
  })
  .when('/posts/:id/edit', {
    templateUrl: "editPost.html",
    controller: 'PostController'
  })
  .otherwise('/');

  $locationProvider.html5Mode(true);
}]);
