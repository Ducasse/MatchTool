Extension { #name : #RBProgramNode }

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> command [
	^ self propertyAt: #command
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> command: anObject [
	self propertyAt: #command put: anObject
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> conditionalSelectors [
	| selectors |
	selectors := OrderedCollection new.
	selectors
		add: #ifFalse:;
		add: #ifFalse:ifTrue:;
		add: #ifNil:;
		add: #ifNil:ifNotNil:;
		add: #ifNotNil:;
		add: #ifNotNil:ifNil:;
		add: #ifTrue:;
		add: #ifTrue:ifFalse:;
		add: #or:;
		add: #and:.
	^ selectors
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> getSequenceParent [
	^ self isSequence
		ifTrue: [ self ]
		ifFalse: [ self parent getSequenceParent ]
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> initialize [
	self oldNodes: OrderedCollection new
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> isInTemporariesList [
	^ false
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> oldNodes [
	^ self propertyAt: #oldNodes
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> oldNodes: anObject [
	self propertyAt: #oldNodes put: anObject
]

{ #category : #'*MatchTool-RewriteTool' }
RBProgramNode >> optionsForNode [
	| options |
	options := OrderedCollection new.
	self isInTemporariesList
		ifFalse: [ options add: #('Change/Rename' #change) ].
	self oldNodes ifNotEmpty: [ options add: #('Undo on node' #undoOnNode) ].
	^ options
]
