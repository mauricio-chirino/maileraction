export function eagerLoadControllersFrom(context, application) {
    const controllers = context.keys().map((key) => context(key).default);
    controllers.forEach((controller) => {
        const controllerName = controller.name.replace(/Controller$/, "").toLowerCase();
        application.register(controllerName, controller);
    });
}
