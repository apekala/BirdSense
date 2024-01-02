from contextlib import contextmanager
import os
import sys

@contextmanager
def suppress_stdout():
    """
    Context manager for running code without printing to standard output
    :return:
    """
    with open(os.devnull, "w") as devnull:
        old_stdout = sys.stdout
        sys.stdout = devnull
        try:
            yield
        finally:
            sys.stdout = old_stdout
