# Functions to manipulate time in ARTIQ

Sinara being a real-time system gives fine grain control of instruction scheduling to the user through the ARTIQ-python library. An introductary discussion on revelant RTIO concepts can be found on the [official manual](https://m-labs.hk/artiq/manual/rtio.html). In this page, we take it one step further and organize the actual commands ARTIQ provides to perform timing controls.

## Conceptual prerequisite
* **RTIO timeline cursor (Time cursor)** - A pointer used to schedule when an instruction should be executed
* **Hardware RTIO counter (wall clock)** - The current cycle the hardware is executing in
* **Slack** - difference between the cursor and wall clock. Cursor should always be ahead of wall clock.

## Key function to manipulate time in ARTIQ
| Action | Functions & Descriptions |
| :--- | :--- |
| To read the time cursor |`now_mu()` |
| To update the time cursor |`at_mu()` - set to a specific time value<br>`delay()` and `delay_mu()` - increase cursor by a given amount |
| To read the wall clock | `self.core.get_rtio_counter_mu()` |
| To reference the two clocks | `self.core.wait_until_mu()` - progress wall clock to catch up to time cursor<br>`self.core.break_realtime()` - set time cursor to > (125000 + wall clock)<br>`self.core.reset()` - init and set time cursor to = (125000 + wall clock) |
| Helper functions | `self.core.mu_to_seconds()`<br>`self.core.mu_to_seconds()`|

## Appendix: List of functions to manipulate time

Standalone function provided by ARTIQ, in core.py file

| Function | Documentation |
| :--- | :--- |
|`at_mu`	| Sets the RTIO time to the specified absolute value, in machine units.|
|`now_mu` | Retrieve the current RTIO timeline cursor, in machine units. Note the conceptual difference between this and the current value of the hardware RTIO counter.|
|`Delay` and `delay_mu` | Increases the RTIO time by the given amount (in seconds) or (in machine unit).|
	
Functions provided by ARTIQ core class, in core.py file

| Function | Documentation |
| :--- | :--- |
|`self.core.get_rtio_counter_mu`|	Retrieve the current value of the hardware RTIO timeline counter. As the timing of kernel code executed on the CPU is inherently non-deterministic, the return value is by necessity only a lower bound for the actual value of the hardware register at the instant when execution resumes in the caller. For a more detailed description of these concepts.
| `self.core.reset` | Clear RTIO FIFOs, release RTIO PHY reset, and set the time cursor at the current value of the hardware RTIO counter plus a margin of 125000 machine units (one machine unit = 1 ns)|
|`self.core.break_realtime` | Set the time cursor after the current value of the hardware RTIO counter plus a margin of 125000 machine units. If the time cursor is already after that position, this function does nothing.|
|`self.core.wait_until_mu` | Block execution until the hardware RTIO counter reaches the given value. If the hardware counter has already passed the given time, the function returns immediately|
|`self.core.mu_to_seconds`| Convert machine units (fine RTIO cycles) to seconds.|
|`self.core.seconds_to_mu`| Convert seconds to the corresponding number of machine units(fine RTIO cycles). :param seconds: time (in seconds) to convert.|
