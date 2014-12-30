app.controller('UserSessionsController', ['$scope', '$auth', 'flash', function($scope, $auth, flash) {
  $scope.$on('auth:login-error', function(ev, reason) {
    flash.error = reason.errors[0];
  });
  $scope.authenticate = function() {
    $auth.authenticate('github', {
      params: {
        favorite_color: 'blue'
      }
    });
  };
  $scope.try = function() {
    $auth.validateUser();
    console.log('try');
  }
}]);