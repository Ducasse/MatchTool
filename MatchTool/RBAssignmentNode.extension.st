Extension { #name : #RBAssignmentNode }

{ #category : #'*MatchTool-RewriteTool' }
RBAssignmentNode >> optionsForNode [
	| options |
	options := super optionsForNode.
	options add: #('Abstract statement' #abstractStatement).
	^ options
]
