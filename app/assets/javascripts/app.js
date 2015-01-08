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
    controller: 'PostController',
    resolve: {
      auth: function($auth) {
        return $auth.validateUser();
      }
    }
  })
  .when('/posts/:id', {
    templateUrl: "showPost.html",
    controller: 'PostController'
  })
  .when('/posts/:id/edit', {
    templateUrl: "editPost.html",
    controller: 'PostController',
    resolve: {
      auth: function($auth) {
        return $auth.validateUser();
      }
    }
  })
  .when('/sign_in', {
    templateUrl: "newUserSession.html",
    controller: "UserSessionsController"
  })
  .when('/admin', {
    templateUrl: "admin.html",
    resolve: {
      auth: function($auth) {
        return $auth.validateUser();
      }
    }
  })
  .otherwise('/');

  $locationProvider.html5Mode(true);
}]);

// authentication

app.config(['$authProvider', function($authProvider) {
  $authProvider.configure({
    apiUrl: '/api',
    authProviderPaths: {
      github: '/auth/github',
      twitter: '/auth/twitter'
    }
  });
}]);

app.run(['$rootScope', '$location', '$auth', '$q', 'flash', 'User', function($rootScope, $location, $auth, $q, flash, User) {

  var adminRoute = function(route) {
    return _.str.startsWith(route, '/admin');
  }

  var isAdmin = function() {
    var user = $rootScope.user;

    if (user.admin) {
      return true;
    }

    return false;
  }

  $rootScope.$on('auth:login-success', function(ev) {
    flash.success = 'Wooho! Successfully logged in.';
    $location.path('/');
  });

  $rootScope.$on('auth:login-error', function(ev) {
    flash.error = reason.errors[0];
  });

  $rootScope.$on('$routeChangeStart', function (ev, next, current) {
    
  });

  $rootScope.$on('$routeChangeSuccess', function (ev, next, current) {
    if (adminRoute($location.url()) && !isAdmin()) {
      flash.error = "You must be an administrator to access that page."
      $location.path('/')
    }
  });

  $rootScope.$on('$routeChangeError', function (ev, next, current) {
    if (adminRoute($location.url())) {
      flash.error = "Please login."
      $location.path('/sign_in');
    }
  });

}]);
