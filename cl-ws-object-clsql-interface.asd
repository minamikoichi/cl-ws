(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:oos 'asdf:load-op :cl-ws-common)
  (asdf:oos 'asdf:load-op :cl-ws-object))

(in-package :cl-ws-object-asd)

(defsystem :cl-ws-object-clsql-interface
    :description "cl-ws-object-clsql-interface"
    :version "0.1"
    :author "mnmkh"
    :serial T
    :components ((:static-file "cl-ws-object-clsql-interface.asd")
		 (:module :src/object/db
			  :serial T
			  :components ((:file "clsql"))))
    :depends-on (:clsql
		 :clsql-sqlite3))
