#!/bin/bash
email_regex='[[:alnum:]][[:alnum:]._%+-]+@[[:alnum:]][[:alnum:].-]+\.[[:alpha:]]{2,6}'
grep -hEro --binary-files=without-match $email_regex /etc/* | tr '\n' ',' >emails.lst
