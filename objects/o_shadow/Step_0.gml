// o_shadow - Step Event
// If owner no longer exists, destroy this shadow
if (!instance_exists(owner)) {
    instance_destroy();
}
