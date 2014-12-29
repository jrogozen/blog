app.controller('UserSessionsController', ['$scope', '$auth', 'flash', function($scope, $auth, flash) {
  $scope.$on('auth:login-error', function(ev, reason) {
    flash.error = reason.errors[0];
  });
  // $scope.authenticate = function() {
  //   $auth.authenticate('github') 
  //     .then(function(resp) {
  //       console.log(resp);
  //     })
  //     .catch(function(resp) {
  //       console.log(resp);
  //     });
  // };
  $scope.try = function() {
    $auth.validateUser();
    console.log('try');
  }
}]);