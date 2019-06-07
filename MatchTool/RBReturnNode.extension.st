Extension { #name : #RBReturnNode }

{ #category : #'*MatchTool-RewriteTool' }
RBReturnNode >> optionsForNode [
	| options |
	options := super optionsForNode.
	options add: #('Abstract object' #abstractMessage).
	^ options
]
