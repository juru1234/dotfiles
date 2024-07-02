import re

def mark(text, args, Mark, extra_cli_args, *a):
    # This function is responsible for finding all
    # matching text. extra_cli_args are any extra arguments
    # passed on the command line when invoking the kitten.
    # We mark all individual word for potential selection
    pattern = r"[/\.a-zA-Z0-9][/\-\_\.A-Za-z0-9]{3,}(:\d+)?"
    pattern = ['(?:https?://|git@|git://|ssh://|ftp://|file:///)\S+', '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}']
    regex = re.compile(r'\b(' + '|'.join(pattern) + r')\b')

    for idx, m in enumerate(re.finditer(regex, text)):
        # filename = m.group(1)
        # linenum = m.group(2)
        start, end = m.span()
        mark_text = text[start:end].replace('\n', '').replace('\0', '')
        # The empty dictionary below will be available as groupdicts
        # in handle_result() and can contain string keys and arbitrary JSON
        # serializable values.
        yield Mark(idx, start, end, mark_text, {})
