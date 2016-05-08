var PaymentForm = React.createClass({
  getInitialState: function(){
    return {user: {firstName: "",
            lastName: "",
            email: ""},
            address: {streetAddress: "",
            streetAddress2: "",
            city: "",
            state: "",
            zipCode: "",
            country: "",
            phoneNumber: ""}
          };
  },

  render: function () {
    return(
      <form id="user-info">
        
      </form>
    );
  }
});
