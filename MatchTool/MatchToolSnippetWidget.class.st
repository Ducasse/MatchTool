"
A widget with a title label, code area and a  checkbox to switch for method/expression mode.

On accept of the code area the widjet will parse the code into an ast and store it.

The wideget can operate for both smalltalk code and pattern code.
"
Class {
	#name : #MatchToolSnippetWidget,
	#superclass : #ComposablePresenter,
	#instVars : [
		'titleLabel',
		'methodCheckbox',
		'codeArea',
		'ast'
	],
	#category : 'MatchTool'
}

{ #category : #specs }
MatchToolSnippetWidget class >> defaultSpec [

	^ SpecLayout composed newColumn: [ :col | col
		newRow: [ :row | row
			add: #titleLabel;
			add: #methodCheckbox width: 100. ]
		height: 30;
		newRow: [ :row | row
			add: #codeArea ] ];
		yourself
]

{ #category : #'code area api' }
MatchToolSnippetWidget >> accept [

	codeArea accept
]

{ #category : #'event handling' }
MatchToolSnippetWidget >> accept: text notifying: notifier [
	[ ast := self parse: text ]
		on: SyntaxErrorNotification
		do: [ :ex | 
			notifier notify: ex errorMessage at: ex location in: ex errorCode.
			^ false ]
]

{ #category : #accessing }
MatchToolSnippetWidget >> astNode [

	^ ast
]

{ #category : #setup }
MatchToolSnippetWidget >> beForPatternCode [

	self isForPatternCode: true
]

{ #category : #'code area api' }
MatchToolSnippetWidget >> clearCodeSelection [
	codeArea clearSelection 
]

{ #category : #accessing }
MatchToolSnippetWidget >> codeArea [
	^ codeArea
]

{ #category : #'code area api' }
MatchToolSnippetWidget >> hasUnacceptedEdits [
	^ codeArea hasUnacceptedEdits
]

{ #category : #initialization }
MatchToolSnippetWidget >> initializePresenter [
	super initializePresenter.
	titleHolder whenChangedDo: [ :string | titleLabel label: string ].
	methodCheckbox whenChangedDo: [ :bool | codeArea isForMethod: bool ].
	codeArea
		acceptBlock:
			[ :text :notifier | self accept: text notifying: notifier ]
]

{ #category : #initialization }
MatchToolSnippetWidget >> initializeWidgets [
	
	titleLabel := self newLabel.
	methodCheckbox := self newCheckBox.
	codeArea := self instantiate: MatchCodePresenter.
	
	titleLabel label: self title.
	methodCheckbox label: 'Method'.
]

{ #category : #setup }
MatchToolSnippetWidget >> isForMethod [

	^ methodCheckbox state
]

{ #category : #setup }
MatchToolSnippetWidget >> isForMethod: aBool [

	methodCheckbox state: aBool
]

{ #category : #setup }
MatchToolSnippetWidget >> isForPatternCode [

	^ codeArea isForMatch
]

{ #category : #setup }
MatchToolSnippetWidget >> isForPatternCode: aBoolean [

	codeArea isForMatch: aBoolean
]

{ #category : #accessing }
MatchToolSnippetWidget >> methodCheckbox [
	^ methodCheckbox
]

{ #category : #parsing }
MatchToolSnippetWidget >> parse: text [

	^ self isForMethod
		ifTrue: [ self parser parseMethod: text ]
		ifFalse: [ self parser parseExpression: text ]

]

{ #category : #parsing }
MatchToolSnippetWidget >> parser [

	^ self isForPatternCode
		ifTrue: [ RBPatternParser ]
		ifFalse: [ RBParser ]
]

{ #category : #'code area api' }
MatchToolSnippetWidget >> setCodeSelection: anInterval [ 
	
	codeArea setSelection: anInterval
]

{ #category : #accessing }
MatchToolSnippetWidget >> titleLabel [
	^ titleLabel
]

{ #category : #'code area api' }
MatchToolSnippetWidget >> whenCodeEdited: aBlock [

	codeArea whenEdited: aBlock
]

{ #category : #'checkbox api' }
MatchToolSnippetWidget >> whenMethodActivatedDo: aBlock [

	methodCheckbox whenActivatedDo: aBlock
]

{ #category : #'checkbox api' }
MatchToolSnippetWidget >> whenMethodDeactivatedDo: aBlock [

	methodCheckbox whenDeactivatedDo: aBlock
]

{ #category : #'checkbox api' }
MatchToolSnippetWidget >> whenMethodStateChangedDo: aBlock [
	self halt.
	methodCheckbox whenChangedDo: aBlock
]
