from pandare import Panda

panda = Panda(generic="i386")  # Create an instance of panda

# Counter of the number of basic blocks
blocks = 0


# Register a callback to run before_block_exec and increment blocks
@panda.cb_before_block_exec
def before_block_execute(cpustate, transblock):
    global blocks
    blocks += 1


# This 'blocking' function is queued to run in a seperate thread from the main CPU loop
# which allows for it to wait for the guest to complete commands
@panda.queue_blocking
def run_cmd():
    # First revert to the qcow's root snapshot (synchronously)
    panda.revert_sync("root")
    # Then type a command via the serial port and print its results
    print(panda.run_serial_cmd("uname -a"))
    # When the command finishes, terminate the panda.run() call
    panda.end_analysis()


# Start the guest
panda.run()
print("Finished. Saw a total of {} basic blocks during execution".format(blocks))
