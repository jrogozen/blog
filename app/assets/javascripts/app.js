var app = angular.module('blog', [
  'ngRoute',
  'ngResource',
  'ng-token-auth',
  'ngCookies',
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
  .when('/sign_in', {
    templateUrl: "newUserSession.html",
    controller: "UserSessionsController"
  })
  .otherwise('/');

  $locationProvider.html5Mode(true);
}]);

// authentication

app.config(['$authProvider', function($authProvider) {
  $authProvider.configure({
    apiUrl: 'http://localhost:3000/api',
    authProviderPaths: {
      github: '/auth/github',
      twitter: '/auth/twitter'
    }
  });
}]);

app.run(['$rootScope', '$location', function($rootScope, $location) {
  $rootScope.$on('auth:login-success', function(ev) {
    $location.path('/');
  });
  $rootScope.$on('auth:login-error', function(ev) {
  });
  $rootScope.$on('auth:validation-success', function(ev) {
  });
  $rootScope.$on('auth:validation-error', function(ev) {
  });
  $rootScope.$on('auth:invalid', function(ev, reason) {
  });
}]);
