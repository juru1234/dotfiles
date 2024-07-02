import re

def mark(text, args, Mark, extra_cli_args, *a):
    # This function is responsible for finding all
    # matching text. extra_cli_args are any extra arguments
    # passed on the command line when invoking the kitten.
    # We mark all individual word for potential selection
    pattern = [
    ## markdown_url
    '\[[^]]*\]\(([^)]+)\)',
    ## url
    '(?:https?:##|git@|git://|ssh://|ftp://|file:///)\S+',
    ## diff_a
    '--- a/(\S+)',
    ## diff_b
    '\+\+\+ b/(\S+)',
    ## docker
    'sha256:([0-9a-f]{64})',
    ## path
    '(?:[.\w\-@~]+)?(?:/[.\w\-@]+)+',
    ## color
    '#[0-9a-fA-F]{6}',
    ## uuid
    '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}',
    ## ipfs
    'Qm[0-9a-zA-Z]{44}',
    ## sha
    '[0-9a-f]{7,40}',
    ## ip
    '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}',
    ## ipv6
    '[A-f0-9:]+:+[A-f0-9:]+[%\w\d]+',
    ## address
    '0x[0-9a-fA-F]+',
    ## number
    '[0-9]{4,}',
    ]
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
