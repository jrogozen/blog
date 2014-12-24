var app = angular.module('blog', [
  'ngRoute',
  'ngResource',
  'templates',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
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
  .when('/posts/:postId', {
    templateUrl: "show.html",
    controller: 'PostController'
  });

  $locationProvider.html5Mode(true);
}]);
