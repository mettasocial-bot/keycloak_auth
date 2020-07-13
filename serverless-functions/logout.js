export async function index(event) {
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'Logout service',
        input: event,
      },
      null,
      2
    ),
  };
};
