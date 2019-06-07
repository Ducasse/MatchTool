Extension { #name : #RBStringReplaceRule }

{ #category : #'*MatchTool-RewriteTool' }
RBStringReplaceRule >> lhs [
	^ searchTree
]

{ #category : #'*MatchTool-RewriteTool' }
RBStringReplaceRule >> rhs [
	^ replaceTree
]
