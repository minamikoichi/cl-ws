(in-package :cl-user)

(asdf:defsystem :cl-ws-common
    :description "cl-ws-common"
    :version "0.1"
    :author "mnmkh"
    :serial T
    :pathname "src/common/"
    :components ((:file "common"))
    :depends-on (:skip))
